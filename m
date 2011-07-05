From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Subject: Re: SATA EH reset renames device (caused by smart self-tests?)
Date: Tue, 05 Jul 2011 08:49:48 +0300
Message-ID: <4E12A5FC.1010608@gmail.com>
References: <4E104989.6070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:64896 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab1GEFtx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jul 2011 01:49:53 -0400
In-Reply-To: <4E104989.6070702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 07/03/2011 01:50 PM, T=F6r=F6k Edwin wrote:
> Hi,
>=20
> I got this SATA EH reset on a disk part of RAID, and after recovery i=
t got renamed
> from /dev/sdd to /dev/sdj.  Would've been good if the original name w=
as kept, as it'd have been easier to readd.
> See below for the SATA link reset messages.
> Don't know what that SError is, I've run a SMART short self-test and =
everything was good, no errors logged.
>=20
> While running smartctl -t short I noticed another EH reset though, so=
 could it be that these EH resets
> occur when the drive is a bit busy with running its automatic SMART s=
elf-tests?

Apparently this was all due to a loose SATA cable (was plugged in only =
about 3/4),
plugged it in again, and its working now.

Best regards,
--Edwin
