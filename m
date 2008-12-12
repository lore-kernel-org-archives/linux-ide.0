From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: Intel X25-M MLC SSD benchmarks
Date: Thu, 11 Dec 2008 21:55:56 -0700
Message-ID: <311601c90812112055i7ec955d6kf4fc13279817cdb0@mail.gmail.com>
References: <20081210213937.GC25548@parisc-linux.org>
	 <83CA05F64804AF43B8F733C4ABDFAA51022D04D7@mail1.bitband.com>
	 <311601c90812111927t54ed6a54oac3154dba30f737d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:4795 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958AbYLLEz5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Dec 2008 23:55:57 -0500
In-Reply-To: <311601c90812111927t54ed6a54oac3154dba30f737d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raz Ben-Yehuda <razb@bitband.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On 12/11/08, Eric D. Mudama <edmudama@gmail.com> wrote:
> Out of curiosity, is write cache enabled or disabled on these devices?

Oops, I just noticed the oflag=direct, that can have a huge
performance difference depending on the block size.

What numbers are you getting without oflag=direct?
