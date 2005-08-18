From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: when are buffers/caches flushed?
Date: Thu, 18 Aug 2005 15:03:31 +0200
Message-ID: <58cb370e050818060317096d32@mail.gmail.com>
References: <43046817.803@imc-berlin.de> <43046FD2.4080401@gmail.com>
	 <43047229.7010007@imc-berlin.de> <43047830.4060705@gmail.com>
	 <58cb370e0508180524145d846a@mail.gmail.com>
	 <20050818124445.GA11164@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.197]:35941 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932221AbVHRNDc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 09:03:32 -0400
Received: by nproxy.gmail.com with SMTP id x37so112386nfc
        for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 06:03:31 -0700 (PDT)
In-Reply-To: <20050818124445.GA11164@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>, linux-ide@vger.kernel.org

On 8/18/05, Tejun Heo <htejun@gmail.com> wrote:
> 
>  Hmmm, disks are not removed on shutdown, so it's not called on
> shutdown.

Yep, I got confused that you meant driver removal.

> > > from ide_device_shutdown()...

above is called on device shutdown

Thanks,
Bartlomiej
