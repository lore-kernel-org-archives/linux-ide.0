From: Tejun Heo <htejun@gmail.com>
Subject: Re: NCQ change  on 2007-12-07
Date: Thu, 13 Mar 2008 12:28:10 +0900
Message-ID: <47D89F4A.7090008@gmail.com>
References: <D8AE5DC69BFCA64989BE8E46BCF0047303B24F2E@MAPLE.conncoll.edu> <47D76B7D.8010808@gmail.com> <D8AE5DC69BFCA64989BE8E46BCF0047303B24F2F@MAPLE.conncoll.edu> <47D89A58.6010301@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:9749 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYCMD2P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 23:28:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3762378wah.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2008 20:28:15 -0700 (PDT)
In-Reply-To: <47D89A58.6010301@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: "Lanstein, Alex C" <aclan@conncoll.edu>, linux-ide@vger.kernel.org

Hello,

Robert Hancock wrote:
> I don't think the driver is to blame for this one. CPB resp_flags of 2
> indicates the controller says that tag is "released", i.e. drive has
> been given the command but not completed. If it's timing out in that
> state, either the NCQ implementation is bad enough that it allows
> certain queued commands to starve for over 30 seconds, or the drive is
> just forgetting about them entirely.
> 
> Unfortunately, if the firmware revision does indeed appear the same on
> both sets of drives, the only automated way we could likely address the
> problem would be to blacklist NCQ on all of those drives of that
> model/revision..

Hmm... it's weird that this problem hasn't been reported on other
controllers.  Lanstein, can you be persuaded into trying out another NCQ
capable controller?

-- 
tejun
