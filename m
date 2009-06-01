From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: [PATCH 0/4] partitions/ide: improve Host Protected Area handling
Date: Mon, 1 Jun 2009 09:02:11 -0400
Message-ID: <87f94c370906010602o2266c4a7s4fca46cf24cea004@mail.gmail.com>
References: <20090531143911.7164.26834.sendpatchset@localhost.localdomain>
	 <20090531152403.GA26987@ub> <200905311735.01244.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:54044 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbZFANCO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2009 09:02:14 -0400
In-Reply-To: <200905311735.01244.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Frans Pop <elendil@planet.nl>

On Sun, May 31, 2009 at 11:34 AM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Sunday 31 May 2009 17:24:03 Andries E. Brouwer wrote:
>> On Sun, May 31, 2009 at 04:39:11PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> [HPA stuff deleted]
>>
>> Hi Bartlomiej,
>>
>> Apart from HPA one also has DCO, which functions rather similarly.
>> (I have not checked whether the current kernel knows anything about DCO.)
>> Have you thought about DCO?
>> Probably the kernel should by default not touch any such setting.
>> Maybe it should be reported?
>> A user space utility might change this setting - thus a disk can change size.
>
> We leave DCO handling entirely to user-space currently.

And to the best of my knowledge user-space leaves it entirely to the kernel.

ie. There is no opensource Linux solution I know of.

Greg
-- 
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
