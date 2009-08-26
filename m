From: Kurt Newman <knewman@globaldataguard.com>
Subject: Re: aic94xx and the adaptec sata raid controller (aic-9410)
Date: Wed, 26 Aug 2009 15:57:08 -0500
Message-ID: <4A95A1A4.2040609@globaldataguard.com>
References: <4A956C59.2010709@globaldataguard.com> <1251313961.14771.5.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.globaldataguard.com ([67.210.231.115]:40926 "EHLO
	mail2.globaldataguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbZHZU4v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2009 16:56:51 -0400
In-Reply-To: <1251313961.14771.5.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-ide@vger.kernel.org

James Bottomley wrote:
>> My question is:
>> Does the aic94xx driver enable the use of the Adaptec SATA Raid
>> functionality, such that, I'm able to see a single "raided" drive,
>> instead of multiple, individual ones.
> 
> no ... the raid add on for the 94xx was Aic proprietary.   To get RAID
> to work you need to use the linux md software RAID.

After further research into learning what HostRAID (read: software raid)
really is, you're definitely correct.  As far as I can tell, there
wouldn't be much of a gain from using that driver anyways.

Since I've already been using linux md to begin, I might as well
continue to do so.

Was just a fruitless hope that it would simplify the development process.

Thanks for the response.
Kurt

