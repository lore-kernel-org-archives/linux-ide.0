From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper layers
Date: Sun, 05 Aug 2007 16:58:37 +0400
Message-ID: <46B5C97D.20004@ru.mvista.com>
References: <200707270222.28230.bzolnier@gmail.com> <200707272119.19438.bzolnier@gmail.com> <46AB91A2.6060303@ru.mvista.com> <200708040101.34574.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:62304 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756586AbXHEM4f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Aug 2007 08:56:35 -0400
In-Reply-To: <200708040101.34574.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>    I have a feeling that only pdc202xx_new and jmicron drivers actually need 
>>this flag (and the latter one actually doesn't care as its methods are empty 
>>anyway).  Well, AMD/VIA chips enable UltraDMA mode by snooping Set Features 
>>command (as the drivers tell them to do so), so the order seems important 
>>unless that is changed.

    I've mixed it up (again :-): setting the MSB of the UltraDMA registers 
should be disabling Set Features snooping, so still the flag doesn't seem 
needed...

> Since changing of order affects the way in which hardware is accessed
> I prefer to keep such changes out of this patch (which is just a cleanup).

    I understand.

> Could you please handle them in pre or post patch(es)?

    More likely in post-patches -- I'll probably be out-of-office for the next 
several weeks (only appearing at weekends).

> Bart

WBR, Sergei
