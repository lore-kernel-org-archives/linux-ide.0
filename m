From: Tejun Heo <tj@kernel.org>
Subject: Re: Red leds at harddisk bays on SR1530HSH after update to 2.6.27.x
Date: Mon, 22 Dec 2008 11:21:21 +0900
Message-ID: <494EF9A1.90002@kernel.org>
References: <494A34CA.9030906@bigtelecom.ru> <20081219223246.b0aea84d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56449 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbYLVCVd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Dec 2008 21:21:33 -0500
In-Reply-To: <20081219223246.b0aea84d.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Badalian Vyacheslav <slavon@bigtelecom.ru>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> (cc linux-ide)
> 
> On Thu, 18 Dec 2008 14:32:26 +0300 Badalian Vyacheslav <slavon@bigtelecom.ru> wrote:
> 
>> Hello all.
>> After update from 2.6.26 to 2.6.27 all leds at drive bays now red.
>> SATA controller in AHCI mode.
>> Platform is Intel SR1530HSH
>>
>> Config attached.
>>
>> Any patches for test? Any ideas? Any other info needed? Or i must go to
>> bugtracker? ;)

Does ahci.ahci_em_messages=0 help?

-- 
tejun
