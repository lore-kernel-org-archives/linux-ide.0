From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 1/3] libata: glob_match for ata_device_blacklist
Date: Thu, 01 Jul 2010 11:44:32 -0400
Message-ID: <4C2CB7E0.30408@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <1277998591.2813.24.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:27482 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756729Ab0GAPoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 11:44:34 -0400
In-Reply-To: <1277998591.2813.24.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

On 01/07/10 11:36 AM, James Bottomley wrote:
> On Thu, 2010-07-01 at 11:30 -0400, Mark Lord wrote:
>> Replace rudimentry pattern matching with more capable shell-style globbing.
>> This will enable shrinking ata_device_blacklist[] table in subsequent patches,
>> and helps with future editions to the table, such as matching only the end
>> of a firmware revision string etc..
>
> So we have other identical cases of this list to flag matching ... like
> in SCSI.  How about we move the mechanics to lib and share the code?


I agree wholeheartedly.  But first it has to get upstream.
And it has follow-on patches that depend on it,
so initially I'd like to push it up via the libata tree.
And then.. as in the original post:

> Eventually, this function should move out of libata into lib/string.c or similar (?).
> But since following patches in this series require it for libata,
> let's start with it there, and move things later on.


Cheers!

