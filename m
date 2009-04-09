From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Odd RAID failure
Date: Thu, 9 Apr 2009 14:42:32 -0400
Message-ID: <87f94c370904091142m79c60d7cy2e377c40b2f7f0c1@mail.gmail.com>
References: <20090404173205.GIRT22375.cdptpa-omta01.mail.rr.com@Leslie>
	 <49DE3AB2.5030503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:5346 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203AbZDISmw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 14:42:52 -0400
Received: by an-out-0708.google.com with SMTP id d14so679992and.1
        for <linux-ide@vger.kernel.org>; Thu, 09 Apr 2009 11:42:51 -0700 (PDT)
In-Reply-To: <49DE3AB2.5030503@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: lrhorer@satx.rr.com, linux-ide@vger.kernel.org

On Thu, Apr 9, 2009 at 2:13 PM, Tejun Heo <tj@kernel.org> wrote:
> Lelsie Rhorer wrote:
> ...
>> The issue is the entire array will occasionally pause completely for=
 about
>> 40 seconds when a file is created. =A0This does not always happen, b=
ut the
>> situation is easily reproducible.
>
> Does the kernel whine about anything when this happens?

Tejun,

There is a long thread on linux-raid about this issue:

http://markmail.org/message/a32fsnsaa5mmpthw

Per the thread, Leslie is not seeing anything in the logs.

Greg
--=20
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
=46irst 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.p=
df

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
