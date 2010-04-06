From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH upstream-fixes] libata: disable NCQ on Crucial C300 SSD
Date: Tue, 06 Apr 2010 10:57:28 -0400
Message-ID: <4BBB4BD8.4050604@garzik.org>
References: <4BB9421E.9050007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:30617 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab0DFO5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 10:57:32 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1771758qwh.37
        for <linux-ide@vger.kernel.org>; Tue, 06 Apr 2010 07:57:30 -0700 (PDT)
In-Reply-To: <4BB9421E.9050007@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lethalwp@scarlet.be, Luke Macken <lmacken@redhat.com>

On 04/04/2010 09:51 PM, Tejun Heo wrote:
> Crucial said,
>
>    Thank you for contacting us. We know that with our M225 line of SS=
Ds
>    you sometimes need to disable NCQ (native command queuing) to avoi=
d
>    just the type of errors you're seeing. Our recommendation for the
>    M225 is to add libata.force=3Dnoncq to your Linux kernel boot opti=
ons,
>    under the kernel ATA library option.
>
>    I have sent your feedback to the engineers working on the C300, an=
d
>    asked them to please pass it on to the firmware team. I have been
>    notified that they are in the process of testing and finalizing a
>    new firmware version, that you can expect to see released around t=
he
>    end of April. We=92ll keep you posted as to when it will be availa=
ble
>    for download.
>
> So, turn off NCQ on the drive w/ the current firmware revision.
>
> Reported in the following bug.
>
>    https://bugzilla.kernel.org/show_bug.cgi?id=3D15573
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: lethalwp@scarlet.be
> Reported-by: Luke Macken<lmacken@redhat.com>
> ---
>   drivers/ata/libata-core.c |    3 +++
>   1 file changed, 3 insertions(+)

applied


