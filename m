From: "Pierre Tardy" <tardyp@gmail.com>
Subject: [PATCH] ata_piix.c ICH6M MAP typo.
Date: Thu, 28 Dec 2006 00:19:16 +0100
Message-ID: <826a2b270612271519id1da2a0x671632e8079a02f4@mail.gmail.com>
References: <826a2b270612271514k12e87daag3ec84fc5f0fd8d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_87366_2166757.1167261556747"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:51403 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964785AbWL0XTR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Dec 2006 18:19:17 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1949154nze
        for <linux-ide@vger.kernel.org>; Wed, 27 Dec 2006 15:19:16 -0800 (PST)
In-Reply-To: <826a2b270612271514k12e87daag3ec84fc5f0fd8d0a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

------=_Part_87366_2166757.1167261556747
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I assume, this patch is a typo correction. this still avoids me an
error at boot:
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
ata_piix 0000:00:1f.2: invalid MAP value 0

cheers,

-- 
Pierre

------=_Part_87366_2166757.1167261556747
Content-Type: text/x-patch; name=ata_piix_map.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew8d5l8b
Content-Disposition: attachment; filename="ata_piix_map.patch"

LS0tIGxpbnV4LTIuNi4xOS4xL2RyaXZlcnMvYXRhL2F0YV9waWl4LmMJMjAwNi0xMi0xMSAyMDoz
Mjo1My4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4xOS4xLnBhdGNoZWQvZHJpdmVycy9h
dGEvYXRhX3BpaXguYwkyMDA2LTEyLTI4IDAwOjA2OjQ0LjAwMDAwMDAwMCArMDEwMApAQCAtNDA1
LDcgKzQwNSw3IEBACiAJICovCiAJLm1hcCA9IHsKIAkJLyogUE0gICBQUyAgIFNNICAgU1MgICAg
ICAgTUFQICovCi0JCXsgIFAwLCAgUDIsICBSViwgIFJWIH0sIC8qIDAwYiAqLworCQl7ICBQMCwg
IFAyLCAgTkEsICBOQSB9LCAvKiAwMGIgKi8KIAkJeyBJREUsIElERSwgIFAxLCAgUDMgfSwgLyog
MDFiICovCiAJCXsgIFAwLCAgUDIsIElERSwgSURFIH0sIC8qIDEwYiAqLwogCQl7ICBSViwgIFJW
LCAgUlYsICBSViB9LAo=
------=_Part_87366_2166757.1167261556747--
