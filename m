From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sil4723 boot delay on ASUS P5W-DH Delux
Date: Thu, 18 Oct 2007 23:29:49 +0900
Message-ID: <47176DDD.2040404@gmail.com>
References: <5501535d0710110631g432cf52dpbc707dc912aa3d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:56983 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764085AbXJRO34 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 10:29:56 -0400
Received: by rv-out-0910.google.com with SMTP id k20so172993rvb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 07:29:56 -0700 (PDT)
In-Reply-To: <5501535d0710110631g432cf52dpbc707dc912aa3d03@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjoern Olausson <lkmlist@gmail.com>
Cc: linux-ide@vger.kernel.org

Bjoern Olausson wrote:
> Hello Tejun,
> 
> I found your patchset (20071011: libata-tj-2.6.23-20071011) and applied it
> against latest kernel 2.6.23
> 
> But unfortunately I have to revise your statement on your wiki:
> 
> * The long boot delay on ASUS boards with on-board PMP chips should be
>   fixed by this patchset but I don't have such a board or Sil4723
>   which is used on those boards, so I'm not sure. Anyone up for
>   testing?
> 
> It's not fixed... sry to tell you.

I'll follow up on the bugzilla.  Thanks.

-- 
tejun
