From: Tejun Heo <htejun@gmail.com>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Thu, 17 Apr 2008 07:12:35 +0900
Message-ID: <480679D3.7030705@gmail.com>
References: <200804021524.27222.elendil@planet.nl> <20080415144748.GO7385@csclub.uwaterloo.ca> <48053AD1.8010007@gmail.com> <200804162008.27655.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.240]:65481 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752989AbYDPWMo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:12:44 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1244855rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:12:42 -0700 (PDT)
In-Reply-To: <200804162008.27655.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Frans Pop wrote:
> On Wednesday 16 April 2008, Tejun Heo wrote:
>> Yeah, theoretically, you're right.  The problem is that what breaks when
>> things go wrong.  If you don't probe generic ports by default, harddisks
>> won't be detected on some legacy systems but you can always prompt the
>> user about loading the generic driver.  If you probe generic ports by
>> default, when things go wrong, you break modern machines in an
>> unrecoverable (w/o reset) way.  I'd rather choose bothering the user on
>> legacy machines.
> 
> The problem here is determining whether a machine is "legacy" or not.
> So far in this discussion I've seen no suggestions how to do that (except 
> maybe for my test whether /sys/bus/isa is present), which would mean asking 
> _all_ users, and that's a damned ugly option.

Asking when no harddisk is detected w/ the option to choose it 
explicitly should do for most cases.  No?

-- 
tejun
