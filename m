From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read
 atip wiith cdrecord
Date: Sun, 25 Jun 2006 13:05:59 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0606251304450.28911@yvahk01.tjqt.qr>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
 <20060624144739.78bde590.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux01.gwdg.de ([134.76.13.21]:9656 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932353AbWFYLGK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 07:06:10 -0400
In-Reply-To: <20060624144739.78bde590.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

>>            Summary: kernel hangs when trying to read atip wiith cdrecord
>>     Kernel Version: 2.6.16.1

>> Most recent kernel where this bug did not occur: 2.6.16.1 (yes, the 
>> same version - it works with my dvd-burner, but not with my cd-burner), 
>> the 2.4 series worked with both, but there I have been using ide-scsi)

Can you try a newer version and/or (or both) with an original cdrecord (if 
not already done so) or cdrecord-prodvd?

>> Distribution: Mandriva 9.0 based

>> cdrtools 2.01.01a10

>> Steps to reproduce:
>> I simply try to use "cdrecord dev=ATAPI:1,0,0 -atip" as root.
>> # cdrecord dev=ATAPI:1,0,0 -atip

Try -dev=/dev/hdX



Jan Engelhardt
-- 
