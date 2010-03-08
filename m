From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Mon, 8 Mar 2010 17:46:44 -0600
Message-ID: <51f3faa71003081546x1694780q490f7e07bc9ddb5b@mail.gmail.com>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu>
	 <d2d378041002170814l1da6b022p4902128c604fc84b@mail.gmail.com>
	 <4B7C9CEE.4080902@kernel.org>
	 <d2d378041002201111g7af41a3dpdb2fa300a65d56bf@mail.gmail.com>
	 <4B8085E7.5000501@kernel.org>
	 <d2d378041002211328w6355d2f9ued625de53964cee5@mail.gmail.com>
	 <4B833FA1.8030207@kernel.org>
	 <d2d378041002280924q26b4a159g5ad22a3476ec3e18@mail.gmail.com>
	 <4B8CFAF4.7030303@kernel.org>
	 <d2d378041003081117i63d807a5mefcb6ea113f026a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:48662 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab0CHXqp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 18:46:45 -0500
In-Reply-To: <d2d378041003081117i63d807a5mefcb6ea113f026a4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Cengiz_G=FCnay?= <cgunay@emory.edu>
Cc: Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

2010/3/8 Cengiz G=FCnay <cgunay@emory.edu>:
> Hello,
>
> Sorry for the delay, I was confused about managing so many patches,
> but I realized that you're sending me cumulative patches that I can
> apply to the original. I just want to remind you that I still have th=
e
> patches to the other two files: libata-eh.c =A0libata-sff.c
>
> On Tue, Mar 2, 2010 at 6:48 AM, Tejun Heo <tj@kernel.org> wrote:
>> Hmmm... the drive is timing out even on 4k READ10's. =A0This shouldn=
't
>> really be happening. =A0Can you please try this one?
>
> Applied. It did not change anything visibly (dmesg attached). I have
> also been getting other SCSI errors since we started communicating
> with the device (search for sr0 in dmesg). I wonder if they give any
> hints? Here's one:
>
> sr 4:0:0:0: [sr0] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
> sr 4:0:0:0: [sr0] Sense Key : Aborted Command [current] [descriptor]
> Descriptor sense data with sense descriptors (in hex):
> =A0 =A0 =A0 =A072 0b 00 00 00 00 00 0e 09 0c 00 00 00 02 00 00
> =A0 =A0 =A0 =A000 20 00 00 a0 40
> sr 4:0:0:0: [sr0] Add. Sense: No additional sense information
> sr 4:0:0:0: [sr0] CDB: Read(10): 28 00 00 00 00 00 00 00 40 00
> end_request: I/O error, dev sr0, sector 0

Don't think that part's very useful, that's just the after-effect of
the timeouts in the driver..
