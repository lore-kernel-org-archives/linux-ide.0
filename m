From: Edward Falk <efalk@google.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
Date: Thu, 04 Aug 2005 11:51:31 -0700
Message-ID: <42F263B3.3050509@google.com>
References: <20050728013622.GA14026@htj.dyndns.org> <42E93FB9.6090800@pobox.com> <20050730081734.GA14242@htj.dyndns.org> <42EFFA05.8010003@google.com> <20050804085104.GA10201@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 216-239-45-4.google.com ([216.239.45.4]:25820 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262632AbVHDSvl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Aug 2005 14:51:41 -0400
In-Reply-To: <20050804085104.GA10201@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hi, again, Edward.
> 
>  Bad news...
> 
> On Tue, Aug 02, 2005 at 03:56:05PM -0700, Edward Falk wrote:
> 
>>Again, you would need to fetch them from the returned FIS structure. 
>>Here's a code fragment derived from SiI's issue_soft_reset() function:

Yeah, well, that's what I get for sending code fragments I haven't 
tested.  Stand by, I'll tinker with my own version of the driver and 
send you an improved fragment.

	-ed
