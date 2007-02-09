From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_promise: fix missing PATA cable detection
Date: Fri, 09 Feb 2007 04:27:35 -0500
Message-ID: <45CC3E87.3090807@gmail.com>
References: <200702072129.l17LTujt012924@alkaid.it.uu.se> <45CB2A91.6050208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:31913 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946254AbXBIJ1o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 04:27:44 -0500
Received: by wr-out-0506.google.com with SMTP id 68so839216wri
        for <linux-ide@vger.kernel.org>; Fri, 09 Feb 2007 01:27:44 -0800 (PST)
In-Reply-To: <45CB2A91.6050208@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> This patch adds yet another is-PATA-or-SATA? check, but it's in a
>> cold path so shouldn't matter much. This will be cleaned up if/when
>> PATA ports and SATA ports start using different ops structures.
[--snip--]
> I agree with your comment above -- SATA and PATA ports should use 
> different ops structures

Working on it.  It will be done in a few weeks.

-- 
tejun
