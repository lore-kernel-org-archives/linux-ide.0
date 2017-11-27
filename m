From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V3 04/29] ata: deprecate pci_get_bus_and_slot()
Date: Mon, 27 Nov 2017 11:57:41 -0500
Message-ID: <1511801886-6753-5-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, "open list:LIBATA PATA DRIVERS" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

cGNpX2dldF9idXNfYW5kX3Nsb3QoKSBpcyByZXN0cmljdGl2ZSBzdWNoIHRoYXQgaXQgYXNzdW1l
cyBkb21haW49MCBhcwp3aGVyZSBhIFBDSSBkZXZpY2UgaXMgcHJlc2VudC4gVGhpcyByZXN0cmlj
dHMgdGhlIGRldmljZSBkcml2ZXJzIHRvIGJlCnJldXNlZCBmb3Igb3RoZXIgZG9tYWluIG51bWJl
cnMuCgpHZXR0aW5nIHJlYWR5IHRvIHJlbW92ZSBwY2lfZ2V0X2J1c19hbmRfc2xvdCgpIGZ1bmN0
aW9uIGluIGZhdm9yIG9mCnBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xvdCgpLgoKVXNlIHBjaV9n
ZXRfZG9tYWluX2J1c19hbmRfc2xvdCgpIGFuZCBleHRyYWN0IHRoZSBhY3R1YWwgZG9tYWluIG51
bWJlcgpmcm9tIHRoZSBwZGV2IHBhc3NlZCBpbi4KClNpZ25lZC1vZmYtYnk6IFNpbmFuIEtheWEg
PG9rYXlhQGNvZGVhdXJvcmEub3JnPgotLS0KIGRyaXZlcnMvYXRhL3BhdGFfYWxpLmMgfCAzICsr
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYXRhL3BhdGFfYWxpLmMgYi9kcml2ZXJzL2F0YS9wYXRhX2FsaS5jCmlu
ZGV4IGQxOWNkODguLjBiMTIyZjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRhL3BhdGFfYWxpLmMK
KysrIGIvZHJpdmVycy9hdGEvcGF0YV9hbGkuYwpAQCAtNDY2LDcgKzQ2Niw4IEBAIHN0YXRpYyB2
b2lkIGFsaV9pbml0X2NoaXBzZXQoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiAJCQl0bXAgfD0gMHgw
MTsJLyogQ0RfUk9NIGVuYWJsZSBmb3IgRE1BICovCiAJCXBjaV93cml0ZV9jb25maWdfYnl0ZShw
ZGV2LCAweDUzLCB0bXApOwogCX0KLQlub3J0aCA9IHBjaV9nZXRfYnVzX2FuZF9zbG90KDAsIFBD
SV9ERVZGTigwLDApKTsKKwlub3J0aCA9IHBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xvdChwY2lf
ZG9tYWluX25yKHBkZXYtPmJ1cyksIDAsCisJCQkJCSAgICBQQ0lfREVWRk4oMCwgMCkpOwogCWlm
IChub3J0aCAmJiBub3J0aC0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfQUwgJiYgYWxpX2lzYV9i
cmlkZ2UpIHsKIAkJLyogQ29uZmlndXJlIHRoZSBBTGkgYnJpZGdlIGxvZ2ljLiBGb3Igbm9uIEFM
aSByZWx5IG9uIEJJT1MuCiAJCSAgIFNldCB0aGUgc291dGggYnJpZGdlIGVuYWJsZSBiaXQgKi8K
LS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
