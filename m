From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sun, 09 Aug 2009 18:51:56 -0400
Message-ID: <4A7F530C.9090209@duda.tzo.com>
References: <h5kn9c$51r$1@ger.gmane.org> <20090809072823.GA2130@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:50679 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbZHIWwH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 18:52:07 -0400
Received: from linux.duda.tzo.com ([96.252.13.163]) by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KO400GX4SULON80@vms173001.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Sun, 09 Aug 2009 17:51:58 -0500 (CDT)
In-reply-to: <20090809072823.GA2130@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org

On 08/09/2009 03:28 AM, Borislav Petkov wrote:

>
> If you'd like to test patches you can get Dave's linux-next git repo at
> http://git.kernel.org/?p=linux/kernel/git/davem/ide-next-2.6.git;a=summary
>

I don't have any experience with installing patches from the git repo.
I tried to figure it out, but didn't have much luck.

If there is a FAQ or HOWTO on git patches, I'll read it.

> apply the patch below and catch all boot output from your machine and
> send it to me.

I upgraded to rc5, and applied these patches.

I'm not getting any additional information in my kernel logs.
The rc5 source uses DEBUG_LOG and not IDETAPE_DEBUG_LOG.

Will Dave's ide-next be part of rc6?

Jim


