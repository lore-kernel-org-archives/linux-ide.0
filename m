From: poma <pomidorabelisima@gmail.com>
Subject: n_sectors mismatch - revalidation failed - resume S3
Date: Sun, 18 Jan 2015 11:21:27 +0100
Message-ID: <54BB8927.2090304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:50942 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbbARKVa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2015 05:21:30 -0500
Received: by mail-we0-f172.google.com with SMTP id k11so26764678wes.3
        for <linux-ide@vger.kernel.org>; Sun, 18 Jan 2015 02:21:29 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Mailing-List fedora-kernel <kernel@lists.fedoraproject.org>


Salutem

I saw a couple of open and closed reports as this is resolved, however here it is,
only on resume from S3 aka suspend:

[  126.580725] ata1.00: n_sectors mismatch 1953525168 != 1953516911
[  126.580732] ata1.00: old n_sectors matches native, probably late HPA lock, will try to unlock HPA
[  126.580737] ata1.00: revalidation failed (errno=-5)


with 'libata.ignore_hpa=1' doesn't appear.

3.18.3-200.fc21.x86_64


poma


Ref.
https://www.kernel.org/doc/Documentation/kernel-parameters.txt

libata.ignore_hpa=      [LIBATA] Ignore HPA limit
                libata.ignore_hpa=0       keep BIOS limits (default)
                libata.ignore_hpa=1       ignore limits, using full disk

