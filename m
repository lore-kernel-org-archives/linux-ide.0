From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/7] AMD Geode GX/LX support
Date: Mon, 3 Oct 2005 21:34:26 +0200
Message-ID: <58cb370e0510031234h6ddef197od6c1efb5fa406435@mail.gmail.com>
References: <20051003175851.GG29264@cosmic.amd.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.192]:64542 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932652AbVJCTe2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 15:34:28 -0400
Received: by nproxy.gmail.com with SMTP id x37so173482nfc
        for <linux-ide@vger.kernel.org>; Mon, 03 Oct 2005 12:34:26 -0700 (PDT)
In-Reply-To: <20051003175851.GG29264@cosmic.amd.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com, linux-ide@vger.kernel.org

Hi,

On 10/3/05, Jordan Crouse <jordan.crouse@amd.com> wrote:
> The following is a patch enabling IDE DMA for the CS5535 companion chip.
> linux-ide folks, this is an updated version of the patch that was submitted
> last night by Jaya Kumar.   Both patches share the same history, and probably

Unfortunately it is not updated version of Jaya's patch but the updated version
of the original 2.6.x patch and it misses 2 iterations of bugfixes/cleanups:

http://marc.theaimsgroup.com/?l=linux-ide&m=112832700817260&w=2

>From what I see the main differences between _original_ patch and this one are:
* /proc/ide/cs5535 (sorry but new /proc bloat won't be accepted)
* different way of setting PIO command timings
  (but this method won't ever set timings > 0 if initially timings were bad)
* trusting BIOS to set correct mode also on drive's side (this breaks Power
  Management support and I will prefer to have known state from Linux POV)

It would be the best to join efforts so could somebody from AMD take a look
at Jaya's latest patch and read related linux-ide ML thread?

Thanks,
Bartlomiej
