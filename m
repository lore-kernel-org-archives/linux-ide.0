From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_svw data corruption, strange problems
Date: Mon, 23 Jun 2008 17:56:32 +0900
Message-ID: <485F6540.6000907@kernel.org>
References: <20080617093602.GA28140@elf.ucw.cz> <485EF061.3010601@kernel.org> <20080623082055.GB1850@elf.ucw.cz> <je63s0sfxv.fsf@sykes.suse.de> <20080623085338.GE1850@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35314 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbYFWI5D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 04:57:03 -0400
In-Reply-To: <20080623085338.GE1850@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Andreas Schwab <schwab@suse.de>, kernel list <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org, jgarzik@pobox.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Trivial patch monkey <trivial@kernel.org>

Pavel Machek wrote:
> On Mon 2008-06-23 10:39:40, Andreas Schwab wrote:
>> Pavel Machek <pavel@suse.cz> writes:
>>
>>> +	   controller, the controller could hang. In other cases it
>>> +	   could return partial data returning in data
>>> +	   corruption. This problem has been seen in PPC systems and
>> s/returning/resulting/ ?
> 
> Fix thinko in sata_svw comment.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Please collapse into one patch.  Thanks.

-- 
tejun
