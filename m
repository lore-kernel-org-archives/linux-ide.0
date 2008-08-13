From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands concurrently
Date: Wed, 13 Aug 2008 12:57:57 -0400
Message-ID: <87f94c370808130957g5aa7ac0ax881de81af8e8f926@mail.gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C54D1.5080901@rtr.ca>
	 <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru>
	 <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru>
	 <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru>
	 <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:55988 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756813AbYHMQ56 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 12:57:58 -0400
Received: by wx-out-0506.google.com with SMTP id h29so104958wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 09:57:57 -0700 (PDT)
In-Reply-To: <48A2CE09.9090806@ngs.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wed, Aug 13, 2008 at 8:05 AM, Artem Bokhan <aptem@ngs.ru> wrote:
> When I run 'dd if=/dev/sda of=/dev/null skip=9700 bs=1M' and it meets bad
> block, it takes about
> '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/target4:0:0/4:0:0:0/timeout
> + about 10 seconds' to determine I/O error. Until that IO to device is
> locked, as I understand. I want to reduce the time of lock as  much as
> possible.
>
> dd: reading `/dev/sda': Input/output error
> 240+1 records in
> 240+1 records out
> 252575744 bytes (253 MB) copied, 13.7833 s, 18.3 MB/s
>

Artem,

I'm not sure what your goal is but you might find it interesting that
"Enterprise" versions of some of the drives have fast fail logic built
into them.  ie. They don't internally retry on medium errors.

As I understand it, the concept is if you have a raid setup, you don't
want to waste time retrying a read.  It is better to fail the read
ASAP and get the data from another source.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
