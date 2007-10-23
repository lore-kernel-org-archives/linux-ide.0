From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Tue, 23 Oct 2007 08:52:56 -0200
Message-ID: <471DD288.7010902@mandic.com.br>
References: <47099C24.3010504@mandic.com.br> <471DAA1C.4070608@gmail.com> <471DC728.60705@mandic.com.br> <471DC8F1.9090501@gmail.com> <471DCA74.503@mandic.com.br> <471DCB33.5070108@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030706020108030000020005"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-02.mandic.com.br ([200.225.81.133]:51087 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbXJWKxI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 06:53:08 -0400
In-Reply-To: <471DCB33.5070108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, debian-devel@lists.debian.org, linux-ide@vger.kernel.org, miquels@cistron.nl

This is a multi-part message in MIME format.
--------------030706020108030000020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Renato S. Yamane wrote:
>> Tejun Heo wrote:
>>> Renato S. Yamane wrote:
>>>> Fixed. Patch is attached. Thanks!
>>>
>>> Can you write up something for other debian users so that it can be
>>> included in the linux-ata page && cc Jeff Garzik?
>>
>> Sorry my friend, but I don't have e-mail from Jeff Garzik.
> 
> cc'd.

Jeff, patch is attached.
When I shutdown my laptop, I receive some warnings about linux-ata.
Tejun suggest remove -h option on halt script and this work fine.

Regards,
Renato

--------------030706020108030000020005
Content-Type: text/x-diff;
 name="halt_debian_etch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="halt_debian_etch.patch"

--- /etc/init.d/halt	2007-10-23 08:33:25.000000000 -0200
+++ /etc/init.d/halt2	2007-10-23 08:31:47.000000000 -0200
@@ -44,7 +44,7 @@ do_stop () {
 	hddown=""
 	if grep -qs '^md.*active' /proc/mdstat
 	then
-		hddown="-h"
+		hddown=""
 	fi
 
 	# If INIT_HALT=HALT don't poweroff.

--------------030706020108030000020005--
