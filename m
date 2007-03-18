From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata reports bogus addresses for everything (was PATA_PCMCIA
  cmd port)
Date: Sun, 18 Mar 2007 14:48:31 +0900
Message-ID: <45FCD2AF.90909@gmail.com>
References: <20061217212752.d93816b4.komurojun-mbn@nifty.com>	<20061217040222.GD17561@ftp.linux.org.uk>	<20070211101537.e40fa309.komurojun-mbn@nifty.com>	<20070317220050.380d9f51.komurojun-mbn@nifty.com> <20070317154333.088d77d4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:34138 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbXCRFsh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 01:48:37 -0400
Received: by nz-out-0506.google.com with SMTP id s1so455622nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 22:48:36 -0700 (PDT)
In-Reply-To: <20070317154333.088d77d4@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Komuro <komurojun-mbn@nifty.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Sat, 17 Mar 2007 22:00:50 +0900
> Komuro <komurojun-mbn@nifty.com> wrote:
> 
>> Hi,
>>  
>> The pata_pcmcia driver reports the cmd port is 0x00010100,
>> but actually the cmd port is 0x0100.
>>
>> Is this corect?
> 
> When the pci_iomap patches were applied the ports reported for every
> device went strange.  It appears to display the wrong information
> nowdays. I see the same but I've got many more important things to work
> on before I even bother to look at it.
> 
> My guess is someone is now printing the iomap virtual addresses not the
> bus ones.

Yes, we're printing the ioaddr.* directly and those are all iomapped
addressed now.  I wonder whether we should fix this or push the port
printing to LLDs (with sff helpers in libata-sff).  ahci and
pata_generic sharing one format doesn't sound like a too good idea.
I'll fix it after new init model.

-- 
tejun
