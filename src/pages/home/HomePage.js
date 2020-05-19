import React, { Component } from "react";
import { StyleSheet, Text, View } from "react-native";
import { create } from "dva-core";
import { Provider } from "react-redux";
import home from "./model/home";

// 创建dva实例 可传递配置参数。https://dvajs.com/api/#app-dva-opts
const app = create();
// 装载model对象
app.model(home);
// 实例初始化
app.start();

// 获取redux的store对象供react-redux使用
const store = app._store;

export default class HomePage extends Component {
  render() {
    const { home: { score } = {} } = store.getState();
    return (
      <Provider store={store}>
        <View style={styles.container}>
          <Text>{`redux中分数: ${score}`}</Text>
        </View>
      </Provider>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#FFFFFF"
  }
});
