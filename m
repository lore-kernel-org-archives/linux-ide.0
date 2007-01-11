From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [2.6 patch] let BLK_DEV_AMD74XX depend on X86
Date: Thu, 11 Jan 2007 18:42:44 +0100
Message-ID: <7b0c1f84c4af6d97a0097c039b509bbb@kernel.crashing.org>
References: <20070111134917.GE20027@stusta.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38153 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbXAKRqV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jan 2007 12:46:21 -0500
In-Reply-To: <20070111134917.GE20027@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> It's unlikely that this driver will ever be of any use on other
> architectures.

It's already being used, for example, the AMD8111 is used
one some PowerPC systems (some with IDE connected even).


Segher

