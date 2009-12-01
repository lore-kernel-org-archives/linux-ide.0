From: David Miller <davem@davemloft.net>
Subject: Re: [Bug 14708] New: Option remap63 for OnTrack diskmanager not
 work - kernel panic, unable to mount root filesystem
Date: Mon, 30 Nov 2009 16:28:56 -0800 (PST)
Message-ID: <20091130.162856.147954711.davem@davemloft.net>
References: <bug-14708-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52967
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752470AbZLAA2u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 19:28:50 -0500
In-Reply-To: <bug-14708-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

From: bugzilla-daemon@bugzilla.kernel.org
Date: Tue, 1 Dec 2009 00:22:58 GMT

> http://bugzilla.kernel.org/show_bug.cgi?id=14708
> 
>            Summary: Option remap63 for OnTrack diskmanager not work -
>                     kernel panic, unable to mount root filesystem

This was intentionally removed see:

commit d708c40da83a86551556999e924e27fdc43dad71
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Sat Mar 22 16:40:22 2008 +0100

    ide: mark "hdx=remap" and "hdx=remap63" kernel parameters as obsoleted
    
    Mark "hdx=remap" and "hdx=remap63" kernel parameters as obsoleted
    (they are layering violation and should be dealt with in the same
     way as done by libata - device-mapper should be used instead).
    
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
