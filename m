From: Grant Grundler <grundler@google.com>
Subject: [PATCH] 2.6.28 remove unused sil24_port_multiplier
Date: Tue, 6 Jan 2009 17:59:00 -0800
Message-ID: <da824cf30901061759j60d5f700q9e5ca190040d94d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5b9e81f39f4045fdade8b
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:33463 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbZAGB7G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 20:59:06 -0500
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id n071x4e0024355
	for <linux-ide@vger.kernel.org>; Tue, 6 Jan 2009 17:59:04 -0800
Received: from bwz8 (bwz8.prod.google.com [10.188.26.8])
	by zps75.corp.google.com with ESMTP id n071wZRK011778
	for <linux-ide@vger.kernel.org>; Tue, 6 Jan 2009 17:59:01 -0800
Received: by bwz8 with SMTP id 8so23496470bwz.14
        for <linux-ide@vger.kernel.org>; Tue, 06 Jan 2009 17:59:01 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

--001636c5b9e81f39f4045fdade8b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

AFAICT, struct sil24_port_multiplier isn't used anywhere. Remove it.

Signed-off-by: Grant Grundler <grundler@google.com>

<Patch attached>

--001636c5b9e81f39f4045fdade8b
Content-Type: application/octet-stream;
	name="diff-2.6.28-rc8_sil24_dead_code-01"
Content-Disposition: attachment;
	filename="diff-2.6.28-rc8_sil24_dead_code-01"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fpnca0ko0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL3NhdGFfc2lsMjQuYyBiL2RyaXZlcnMvYXRhL3NhdGFf
c2lsMjQuYwppbmRleCBjY2VlOTMwLi4yNTkwYzIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2F0YS9z
YXRhX3NpbDI0LmMKKysrIGIvZHJpdmVycy9hdGEvc2F0YV9zaWwyNC5jCkBAIC01MSwxMyArNTEs
NiBAQCBzdHJ1Y3Qgc2lsMjRfc2dlIHsKIAlfX2xlMzIJZmxhZ3M7CiB9OwogCi0vKgotICogUG9y
dCBtdWx0aXBsaWVyCi0gKi8KLXN0cnVjdCBzaWwyNF9wb3J0X211bHRpcGxpZXIgewotCV9fbGUz
MglkaWFnOwotCV9fbGUzMglzYWN0aXZlOwotfTsKIAogZW51bSB7CiAJU0lMMjRfSE9TVF9CQVIJ
CT0gMCwK
--001636c5b9e81f39f4045fdade8b--
