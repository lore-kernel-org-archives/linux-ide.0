From: Konstantin Sobolev <kos@supportwizard.com>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 19:16:27 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404151916.27605.kos@supportwizard.com>
References: <200404150236.05894.kos@supportwizard.com> <200404151848.05857.kos@supportwizard.com> <1082041692.19571.82.camel@lotte.street-vision.com>
Reply-To: kos@supportwizard.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.rol.ru ([194.67.21.9]:45243 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S264313AbUDOPNq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2004 11:13:46 -0400
Received: from 81.211.110.66.adsl-spb.net.rol.ru ([81.211.110.66]:43904 "EHLO
	81.211.110.66.adsl-spb.net.rol.ru" smtp-auth: <none> TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by gnome03.net.rol.ru with ESMTP
	id S17475975AbUDOPNn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Apr 2004 19:13:43 +0400
In-Reply-To: <1082041692.19571.82.camel@lotte.street-vision.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Justin Cormack <justin@street-vision.com>
Cc: linux-ide@vger.kernel.org

On Thursday 15 April 2004 19:08, Justin Cormack wrote:
> Ah yes, I noticed that once or twice. Not sure what the reason is. It
> may be something to do with how hdparm tries to deal with bypassing the
> vm, or how the scsi layer deals with block size changes or something. I
> wouldnt worry. It only happens if you do hdparm ever when the block size
> is 512bytes. 68MB/s is pretty nice. Was thinking of getting some of
> those drives.

Thanks a lot! :)
-- 
/KoS
* Life with pets is never dull.					      
