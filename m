From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: make DVD Drive recognisable on systems with
 Intel Sandybridge chipsets(v1)
Date: Thu, 6 Oct 2011 09:54:37 -0700
Message-ID: <20111006165437.GA3953@google.com>
References: <1317433412-15963-1-git-send-email-ming.lei@canonical.com>
 <4E8C2724.7030608@mvista.com>
 <CACVXFVPrZELDuO=Aa+HrccpwnOw7UB5eQEW0=y_aUEt794rHgA@mail.gmail.com>
 <4E8D854F.6000107@mvista.com>
 <CACVXFVO9TWDC-+5g2n6knWErWL4U8zNqBxy99Jc4hDB1VGzKQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33482 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758482Ab1JFQyn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 12:54:43 -0400
Received: by vws1 with SMTP id 1so2396197vws.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2011 09:54:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACVXFVO9TWDC-+5g2n6knWErWL4U8zNqBxy99Jc4hDB1VGzKQQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, seth.heasley@intel.com, Alan Cox <alan@linux.intel.com>

Hello,

On Thu, Oct 06, 2011 at 07:53:46PM +0800, Ming Lei wrote:
> This flag is to stored into ata_port flags, so it is better to define a global
> flag. Otherwise, you have to select a value carefully which must not be
> defined in ata_port flags already, which way is very error-prone and not
> friendly.

Bits 24:31 of ata_port flags are reserved for driver-specific uses.
Also, this is controller-wide not port-wide, so you can also add
piix_host_priv->flags and use it.

> Anyway, I have not see obvious drawbacks to define a global ata_port
> flag.

Sergei is right here.  Please move it to driver specific flags.  If we
end up doing this for multiple controllers, then we can move the flag
(and handling of it too) to generic code.

Thank you.

--
tejun
