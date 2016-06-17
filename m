From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: fix "ering" sysfs time printing
Date: Fri, 17 Jun 2016 12:10:53 -0400
Message-ID: <20160617161053.GK3262@mtj.duckdns.org>
References: <20160617153739.429055-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
Content-Disposition: inline
In-Reply-To: <20160617153739.429055-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-ide@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

T24gRnJpLCBKdW4gMTcsIDIwMTYgYXQgMDU6Mzc6MTJQTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3
cm90ZToKPiBUaGUgc3lzZnMgZmlsZSBmb3IgdGhlIGxpYmF0YSBlcnJvciBoYW5kbGluZyBoYXMg
bXVsdGlwbGUgaXNzdWVzCj4gaW4gdGhlIHdheSBpdCBwcmludHMgdGltZSBzdGFtcHM6Cj4gCj4g
ICogaXQgcHJpbnRzIGEgOS1kaWdpdCBuYW5vc2Vjb25kIHZhbHVlIHVzaW5nIGEgJTA2bHUgZm9y
bWF0IHN0cmluZywKPiAgICB3aGljaCBkcm9wcyBzb21lIGxlYWRpbmcgemVyb2VzCj4gICogaXQg
Y29udmVydHMgYSA2NC1iaXQgamlmZmVzIHZhbHVlIHRvIGEgdGltZXNwZWMgdXNpbmcKPiAgICBq
aWZmaWVzX3RvX3RpbWVzcGVjKCksIHdoaWNoIHRha2VzIGEgJ2xvbmcnIGFyZ3VtZW50LCBzbyB0
aGUKPiAgICByZXN1bHQgaXMgd3JvbmcgYWZ0ZXIgYSBqaWZmaWVzIG92ZXJmbG93ICg0OSBkYXlz
KS4KPiAgKiB3ZSB0cnkgdG8gYXZvaWQgdXNpbmcgdGltZXNwZWMgYmVjYXVzZSB0aGF0IGdlbmVy
YWxseSBvdmVyZmxvd3MKPiAgICBpbiAyMDM4LCBhbHRob3VnaCB0aGlzIHBhcnRpY3VsYXIgdXNh
Z2UgaXMgb2suCj4gCj4gVGhpcyByZXBsYWNlcyB0aGUgamlmZmllc190b190aW1lc3BlYyBjYWxs
IHdpdGggYW4gb3Blbi1jb2RlZAo+IGltcGxlbWVudGF0aW9uIHRoYXQgZ2V0cyBpdCByaWdodC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgoKSGVoLCBJ
J20gbm90IGV2ZW4gc3VyZSB3aHkgd2UncmUgZXhwb3NpbmcgdGhpcyBidXQgaXQncyBhbHJlYWR5
IHRoZXJlLgpBcHBsaWVkIHRvIGxpYmF0YS9mb3ItNC44LgoKVGhhbmtzIQoKLS0gCnRlanVuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClkyMDM4IG1haWxp
bmcgbGlzdApZMjAzOEBsaXN0cy5saW5hcm8ub3JnCmh0dHBzOi8vbGlzdHMubGluYXJvLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3kyMDM4Cg==
