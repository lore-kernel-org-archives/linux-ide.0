From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 12/15] ide-cd: convert to using generic sense request
Date: Sun, 19 Apr 2009 18:30:49 +0900
Message-ID: <49EAEF49.2040200@gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-13-git-send-email-tj@kernel.org> <20090419092254.GB2906@liondog.tnic> <49EAEEB8.10300@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:30214 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZDSJa4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Apr 2009 05:30:56 -0400
Received: by ti-out-0910.google.com with SMTP id 11so1013090tim.23
        for <linux-ide@vger.kernel.org>; Sun, 19 Apr 2009 02:30:54 -0700 (PDT)
In-Reply-To: <49EAEEB8.10300@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Tejun Heo wrote:
>> However, is there any reason for copying back the sense bytes at all?
>> In other words, does the block layer code need sense data when ending a
>> request or is it used only by LLDDs for error handling?

And, yes, SG_IO requests need sense data copied back.

Thanks.

-- 
tejun
