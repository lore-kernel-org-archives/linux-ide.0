From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Thu, 14 Jun 2007 21:25:59 +0900
Message-ID: <467133D7.7070000@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <466FC901.4060907@effenberger.org> <46710DDC.1030900@gmail.com> <467122B8.1090206@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:42777 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbXFNMgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 08:36:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so652835wah
        for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 05:36:07 -0700 (PDT)
In-Reply-To: <467122B8.1090206@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Florian Effenberger wrote:
> Hi,
> 
>> Can you post the result of 'hdparm -I /dev/sdX'?
> 
> thanks a lot for your kind support, that is much appreciated!
> 
> Attached is some machine output, hope that helps. Let me know I you need
> more information.

Okay, ich8.  I don't think the chipset is at fault here and you have a
lot of disks.  My primary suspect is power supply problem but things
like this are hard to prove.  With the merged speed down fix, libata
will do the right thing after a few errors, so ignoring the problem
wouldn't be a too bad idea.  If you're curious, you can try to connect
drives to different SATA ports and power lanes and see whether errors
follow the disk, port or power lane.

-- 
tejun
