From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Tue, 23 Oct 2007 08:04:24 -0200
Message-ID: <471DC728.60705@mandic.com.br>
References: <47099C24.3010504@mandic.com.br> <471DAA1C.4070608@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040602060308090001040001"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-01.mandic.com.br ([200.225.81.132]:54433 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbXJWKEj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 06:04:39 -0400
In-Reply-To: <471DAA1C.4070608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, miquels@cistron.nl

This is a multi-part message in MIME format.
--------------040602060308090001040001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Renato S. Yamane wrote:
>> So, my questions is:
>> - This is dangerous? Can damage something?
> 
> If your drive sounds funny on shutdown, it could.  Your drive is
> supposed to sound the same way it sounds when you execute "hdparm -y
> /dev/sdX".

No strange sounds :-)

>> - How can I help to fix this warning?
> 
> I believe there's already update out but you can edit some configuration
> file (can't remember which ATM) such that "-h" option is not passed to
> halt.

Fixed. Patch is attached. Thanks!

--------------040602060308090001040001
Content-Type: text/x-diff;
 name="halt_debian_etch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="halt_debian_etch.patch"

--- /etc/init.d/halt	2007-10-23 07:51:40.000000000 -0200
+++ /etc/init.d/halt_b	2007-10-23 07:50:52.000000000 -0200
@@ -44,7 +44,7 @@ do_stop () {
 	hddown=""
 	if grep -qs '^md.*active' /proc/mdstat
 	then
-		hddown="-h"
+		hddown=""
 	fi
 
 	# If INIT_HALT=HALT don't poweroff.

--------------040602060308090001040001--
