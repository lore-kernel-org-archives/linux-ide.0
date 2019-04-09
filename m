From: Peng Ma <peng.ma@nxp.com>
Subject: RE: [EXT] Re: [v7 3/3] ahci: qoriq: add lx2160 platforms support
Date: Tue, 9 Apr 2019 06:44:33 +0000
Message-ID: <VI1PR04MB4431213C02A7DC614AB4E693ED2D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190312015019.30628-1-peng.ma@nxp.com>
 <20190312015019.30628-3-peng.ma@nxp.com>
 <VI1PR04MB44310DDDF2D981F0BC0D7381ED2C0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <5bbd312c-6443-ea23-2b3e-97fd46a98a38@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5bbd312c-6443-ea23-2b3e-97fd46a98a38@kernel.dk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jens Axboe <axboe@kernel.dk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jianchao Wang <jianchao.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andy Tang <andy.tang@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

SGkgQXhib2UsDQoNClBhdGNoIGxpbms6DQoNCmh0dHA6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
YXRjaC8xMDU1MDI4Lw0KDQpodHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTA1NDE4
OS8NCg0KQmVzdCBSZWdhcmRzLA0KUGVuZw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj5Gcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+U2VudDogMjAxOcTqNNTCOMjV
IDIzOjIxDQo+VG86IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9y
ZzsNCj5tYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpIDxs
ZW95YW5nLmxpQG54cC5jb20+DQo+Q2M6IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQW5keSBUYW5nDQo+PGFuZHkudGFu
Z0BueHAuY29tPg0KPlN1YmplY3Q6IFtFWFRdIFJlOiBbdjcgMy8zXSBhaGNpOiBxb3JpcTogYWRk
IGx4MjE2MCBwbGF0Zm9ybXMgc3VwcG9ydA0KPg0KPldBUk5JTkc6IFRoaXMgZW1haWwgd2FzIGNy
ZWF0ZWQgb3V0c2lkZSBvZiBOWFAuIERPIE5PVCBDTElDSyBsaW5rcyBvcg0KPmF0dGFjaG1lbnRz
IHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4NCj4NCj4NCj5PbiA0LzgvMTkgNDowNiBBTSwgUGVuZyBNYSB3cm90ZToNCj4+IEhp
IGF4Ym9lLA0KPj4NCj4+IElmIHlvdSBoYXZlIG5vIGNvbW1lbnRzIG9uIHRoZXNlIHBhdGhzLCBw
bGVhc2UgbWVyZ2UuDQo+PiBUaGFuayB5b3UgdmVyeSBtdWNoLg0KPj4gUGF0Y2ggbGluazoNCj4+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
JTNBJTJGJTJGcGF0Y2gNCj4+DQo+d29yay5vemxhYnMub3JnJTJGcGF0Y2glMkYxMDU1MDI4JTJG
JmFtcDtkYXRhPTAyJTdDMDElN0NwZW5nLm1hDQo+JTQwbnhwLg0KPj4NCj5jb20lN0M0MGU4NTk2
NzY2MDY0MzFjZTg0OTA4ZDZiYzM1YmYzZCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDkNCj45YzVj
MzAxDQo+Pg0KPjYzNSU3QzAlN0MxJTdDNjM2OTAzMzM2MzY0MTA5MzIyJmFtcDtzZGF0YT1ROHZF
bE1rYURtSHZwaGhWbw0KPjEyQnRGVXZxWHANCj4+IFQlMkJEQnJudmRqViUyRkZpemZzJTNEJmFt
cDtyZXNlcnZlZD0wDQo+PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnBhdGNoDQo+Pg0KPndvcmsub3psYWJzLm9yZyUyRnBh
dGNoJTJGMTA1NDE4OSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDcGVuZy5tYQ0KPiU0MG54cC4NCj4+
DQo+Y29tJTdDNDBlODU5Njc2NjA2NDMxY2U4NDkwOGQ2YmMzNWJmM2QlN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5DQo+OWM1YzMwMQ0KPj4NCj42MzUlN0MwJTdDMSU3QzYzNjkwMzMzNjM2NDEwOTMy
MiZhbXA7c2RhdGE9SE51aUd6JTJCaGZlZ2NnTlE3DQo+VCUyQlBxR1BJDQo+PiBiUzNjaCUyRlVx
dHhtSEJmTDZNb1JvJTNEJmFtcDtyZXNlcnZlZD0wDQo+DQo+Q2FuIHlvdSByZXNlbmQsIGl0J3Mg
bm90IGNsZWFyIHdoaWNoIGlzIHdoaWNoIGhlcmUsIGFuZCB3aGF0IHBhcnRzIG9mIHRoZSBzZXJp
ZXMNCj5nb2VzIHdoZXJlLg0KPg0KPi0tDQo+SmVucyBBeGJvZQ0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
