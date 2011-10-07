From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ata_piix: make DVD Drive recognisable on systems with
 Intel Sandybridge chipsets(v1)
Date: Fri, 7 Oct 2011 11:31:02 +0800
Message-ID: <CACVXFVMny_pjPBAs8n1ztNHVGe2ZVkZzGPV-mvtXswQhU_rkWQ@mail.gmail.com>
References: <1317433412-15963-1-git-send-email-ming.lei@canonical.com>
	<4E8C2724.7030608@mvista.com>
	<CACVXFVPrZELDuO=Aa+HrccpwnOw7UB5eQEW0=y_aUEt794rHgA@mail.gmail.com>
	<4E8D854F.6000107@mvista.com>
	<CACVXFVO9TWDC-+5g2n6knWErWL4U8zNqBxy99Jc4hDB1VGzKQQ@mail.gmail.com>
	<20111006165437.GA3953@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50025 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759534Ab1JGDbH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 23:31:07 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RC19N-0000qC-HW
	for linux-ide@vger.kernel.org; Fri, 07 Oct 2011 03:31:05 +0000
Received: by ggnv2 with SMTP id v2so2376831ggn.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2011 20:31:03 -0700 (PDT)
In-Reply-To: <20111006165437.GA3953@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, seth.heasley@intel.com, Alan Cox <alan@linux.intel.com>

Hi,

On Fri, Oct 7, 2011 at 12:54 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> On Thu, Oct 06, 2011 at 07:53:46PM +0800, Ming Lei wrote:
>> This flag is to stored into ata_port flags, so it is better to defin=
e a global
>> flag. Otherwise, you have to select a value carefully which must not=
 be
>> defined in ata_port flags already, which way is very error-prone and=
 not
>> friendly.
>
> Bits 24:31 of ata_port flags are reserved for driver-specific uses.
> Also, this is controller-wide not port-wide, so you can also add
> piix_host_priv->flags and use it.
>
>> Anyway, I have not see obvious drawbacks to define a global ata_port
>> flag.
>
> Sergei is right here. =A0Please move it to driver specific flags. =A0=
If we
> end up doing this for multiple controllers, then we can move the flag
> (and handling of it too) to generic code.

OK, will update the patch to use local flag.

thanks,
--
Ming Lei
