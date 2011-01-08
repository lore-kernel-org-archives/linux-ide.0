From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] pata_hpt37x: coding style cleanup
Date: Sat, 08 Jan 2011 15:30:29 -0500
Message-ID: <4D28C965.8070008@pobox.com>
References: <201101081901.37479.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57875 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1AHUae (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 15:30:34 -0500
Received: by vws16 with SMTP id 16so7599329vws.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 12:30:33 -0800 (PST)
In-Reply-To: <201101081901.37479.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 01/08/2011 11:01 AM, Sergei Shtylyov wrote:
> Changes from the previous version:
> - fixed several cases of a line over 80 chars that checkpatch.pl didn't report.

And for pata_hpt366 you also wrote:
> Changes from the previous version:
> - fixed one case of a line over 80 chars that checkpatch.pl didn't report.

These will need to be on top of your patches applied last night (and 
just sent to Linus).

FWIW, it is ok to combine such changes into a single patch.  You don't 
have to separate our pata_hpt37x and pata_hpt366 coding style cleanups. 
  The main goal with separate patches is separating classes of changes, 
so that human reviewers and 'git bisect' may notice breakage at a 
useful, fine-grained level.  Separating patches at the driver boundary 
is less useful from that perspective (though permissible, if that is 
your preferred method of working).

	Jeff



