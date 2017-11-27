From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V3 11/29] Drivers: ide: deprecate
	pci_get_bus_and_slot()
Date: Mon, 27 Nov 2017 11:57:48 -0500
Message-ID: <1511801886-6753-12-git-send-email-okaya@codeaurora.org>
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
Cc: linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, "open list:IDE SUBSYSTEM" <linux-ide@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

cGNpX2dldF9idXNfYW5kX3Nsb3QoKSBpcyByZXN0cmljdGl2ZSBzdWNoIHRoYXQgaXQgYXNzdW1l
cyBkb21haW49MCBhcwp3aGVyZSBhIFBDSSBkZXZpY2UgaXMgcHJlc2VudC4gVGhpcyByZXN0cmlj
dHMgdGhlIGRldmljZSBkcml2ZXJzIHRvIGJlCnJldXNlZCBmb3Igb3RoZXIgZG9tYWluIG51bWJl
cnMuCgpHZXR0aW5nIHJlYWR5IHRvIHJlbW92ZSBwY2lfZ2V0X2J1c19hbmRfc2xvdCgpIGZ1bmN0
aW9uIGluIGZhdm9yIG9mCnBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xvdCgpLgoKUmVwbGFjZSBw
Y2lfZ2V0X2J1c19hbmRfc2xvdCgpIHdpdGggcGNpX2dldF9kb21haW5fYnVzX2FuZF9zbG90KCkK
YW5kIGV4dHJhY3QgdGhlIGRvbWFpbiBudW1iZXIgZnJvbSBzdHJ1Y3QgcGNpX2Rldi4KClNpZ25l
ZC1vZmYtYnk6IFNpbmFuIEtheWEgPG9rYXlhQGNvZGVhdXJvcmEub3JnPgotLS0KIGRyaXZlcnMv
aWRlL3NsODJjMTA1LmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWRlL3NsODJjMTA1LmMgYi9k
cml2ZXJzL2lkZS9zbDgyYzEwNS5jCmluZGV4IDg3NTVkZjMuLjMzMDBkYWMgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvaWRlL3NsODJjMTA1LmMKKysrIGIvZHJpdmVycy9pZGUvc2w4MmMxMDUuYwpAQCAt
MjM5LDggKzIzOSw5IEBAIHN0YXRpYyB1OCBzbDgyYzEwNV9icmlkZ2VfcmV2aXNpb24oc3RydWN0
IHBjaV9kZXYgKmRldikKIAkvKgogCSAqIFRoZSBicmlkZ2Ugc2hvdWxkIGJlIHBhcnQgb2YgdGhl
IHNhbWUgZGV2aWNlLCBidXQgZnVuY3Rpb24gMC4KIAkgKi8KLQlicmlkZ2UgPSBwY2lfZ2V0X2J1
c19hbmRfc2xvdChkZXYtPmJ1cy0+bnVtYmVyLAotCQkJICAgICAgIFBDSV9ERVZGTihQQ0lfU0xP
VChkZXYtPmRldmZuKSwgMCkpOworCWJyaWRnZSA9IHBjaV9nZXRfZG9tYWluX2J1c19hbmRfc2xv
dChwY2lfZG9tYWluX25yKGRldi0+YnVzKSwKKwkJCQkJZGV2LT5idXMtPm51bWJlciwKKwkJCQkJ
UENJX0RFVkZOKFBDSV9TTE9UKGRldi0+ZGV2Zm4pLCAwKSk7CiAJaWYgKCFicmlkZ2UpCiAJCXJl
dHVybiAtMTsKIAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2ludGVsLWdmeAo=
