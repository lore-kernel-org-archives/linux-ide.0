From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 16 Feb 2007 10:48:36 +0100
Message-ID: <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com>
	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>
	 <45D56FE4.3090900@tw.ibm.com>
	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>
	 <45D574B1.8080109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:1046 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423526AbXBPJsi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 04:48:38 -0500
Received: by wr-out-0506.google.com with SMTP id i31so1042305wra
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 01:48:37 -0800 (PST)
In-Reply-To: <45D574B1.8080109@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org

On 2/16/07, Albert Lee <albertcc@tw.ibm.com> wrote:
> Maybe the Promise BIOS set the adapter as disabled...
> Could you please try the attached patch?

This patch is against what? I get a hunk rejected.
patching file drivers/ata/pata_pdc2027x.c
Hunk #1 FAILED at 315.
1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/pata_pdc2027x.c.rej

Can you make a patch against the libata-dev tree that I pulled last night?
It's impossible for me to reboot at the moment since my grub gives me
an attitude.

If it's too much work, don't worry, I can test it when I am at home :)


Thanks for your time so far.


Patrick
