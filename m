From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] libata: fix for transport xfer attributes
Date: Fri, 14 Oct 2011 12:12:26 -0700
Message-ID: <CANEJEGtzwQkDG1KmqVizmW8=SWuhYgjH02TgLaQzU-76TYUZZg@mail.gmail.com>
References: <201110132203.45394.bzolnier@gmail.com>
	<4E9762DE.1060009@pobox.com>
	<201110141158.33983.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:63188 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab1JNTMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Oct 2011 15:12:30 -0400
Received: from hpaq13.eem.corp.google.com (hpaq13.eem.corp.google.com [172.25.149.13])
	by smtp-out.google.com with ESMTP id p9EJCTAX001059
	for <linux-ide@vger.kernel.org>; Fri, 14 Oct 2011 12:12:29 -0700
Received: from qyk30 (qyk30.prod.google.com [10.241.83.158])
	by hpaq13.eem.corp.google.com with ESMTP id p9EJ6mSZ001562
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 14 Oct 2011 12:12:28 -0700
Received: by qyk30 with SMTP id 30so586369qyk.9
        for <linux-ide@vger.kernel.org>; Fri, 14 Oct 2011 12:12:27 -0700 (PDT)
In-Reply-To: <201110141158.33983.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou ` <gwendal@google.com>

On Fri, Oct 14, 2011 at 2:58 AM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
=2E..
>> "fix" or not it is an ABI change... who is impacted? =C2=A0Has anyon=
e used
>> the current, pre-patch behavior as documented?
>
> I doubt that anyone has used it given the current incorrect behavior =
but lets
> ask libata transport authors..

Gwendal is the primary author.

I'm not aware of any uses either.

Based on this kernel.org documentation:
    http://www.kernel.org/doc/Documentation/ABI/testing/sysfs-ata

    "xfer_mode   Current transfer mode."

I agree with Bartomiej that current behavior is incorrect.

cheers,
grant
