From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] add new nForce IDE/SATA device IDs
Date: Thu, 27 May 2004 15:38:00 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40B64398.7090808@pobox.com>
References: <C064BF1617D93B4B83714E38C4653A6E0AF48248@mail-sc-10.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46308 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265096AbUE0TiR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 May 2004 15:38:17 -0400
In-Reply-To: <C064BF1617D93B4B83714E38C4653A6E0AF48248@mail-sc-10.nvidia.com>
List-Id: linux-ide@vger.kernel.org
To: Brian Lazara <blazara@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Brian Lazara wrote:
> Patches to add device IDs for new nForce IDE and SATA controllers.
> Rename some of the existing controller names to correctly match released
> product names.
> 
> Patches against 2.4.27-pre2 and 2.6.6

It is difficult to review patches that look like the following... 
please include the patches include, or attach them as plaintext.

Three other comments:

1) please CC linux-ide@vger.kernel.org on all IDE/SATA-related patches
2) Please To: or CC: Bartlomiej (cc'd on this email) on all drivers/ide 
patches, as he is the IDE maintainer.
3) Normally we want to add SATA support to libata not drivers/ide.  Do 
the nVidia SATA chips support SATA SCRs or anything like that?  Why not 
use libata?


Content-Type: application/octet-stream;
	name="linux-2.4.27-pre2-nforce-ck804-ide.patch"
Content-Transfer-Encoding: base64
Content-Description: linux-2.4.27-pre2-nforce-ck804-ide.patch
Content-Disposition: attachment;
	filename="linux-2.4.27-pre2-nforce-ck804-ide.patch"

ZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjQuMjctcHJlMi9kcml2ZXJzL2lkZS9wY2kv
YW1kNzR4eC5jIGxpbnV4LTIuNC4yNy1wcmUyLW5mb3JjZS1jazgwNC1pZGUvZHJpdmVycy9pZGUv
cGNpL2FtZDc0eHguYwotLS0gbGludXgtMi40LjI3LXByZTIvZHJpdmVycy9pZGUvcGNpL2FtZDc0
eHguYwkyMDA0LTA0LTE0IDA2OjA1OjI5LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi40LjI3
LXByZTItbmZvcmNlLWNrODA0LWlkZS9kcml2ZXJzL2lkZS9wY2kvYW1kNzR4eC5jCTIwMDQtMDUt
MTcgMTM6Mjc6MzEuMDAwMDAwMDAwIC0wNzAwCkBAIC0xLDcgKzEsOCBAQAogLyoKICAqIFZlcnNp
b24gMi4xMwogICoKLSAqIEFNRCA3NTUvNzU2Lzc2Ni84MTExIGFuZCBuVmlkaWEgbkZvcmNlLzIv
MnMvMy8zcyBJREUgZHJpdmVyIGZvciBMaW51eC4KKyAqIEFNRCA3NTUvNzU2Lzc2Ni84MTExIGFu
ZCBuVmlkaWEgbkZvcmNlLzIvMnMvMy8zcy9DSzgwNC9NQ1AwNCAKKyAqIElERSBkcml2ZXIgZm9y
