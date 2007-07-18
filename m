From: "Yasha Okshtein" <flyashi@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Tue, 17 Jul 2007 21:04:27 -0700
Message-ID: <6b01c6170707172104s62408da6yc11f239cc2a37860@mail.gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
	 <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
	 <469D8A99.8050102@gmail.com>
Reply-To: flyashi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:16520 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbXGREE2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 00:04:28 -0400
Received: by fk-out-0910.google.com with SMTP id z23so6442fkz
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 21:04:27 -0700 (PDT)
In-Reply-To: <469D8A99.8050102@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Well ideally this should work with a port multiplier to soft/hardreset
only one disk behind the multiplier. Also, this again doesn't allow
the user to specify soft or hard reset - I believe rescanning forces
hardresets. Fully implementing the SATA spec, which should eventually
be done anyway, seems like a cleaner solution.

On 7/17/07, Tejun Heo <htejun@gmail.com> wrote:
> Yasha Okshtein wrote:
> > I need to send soft and/or hard resets from userspace.
>
> Actually, you can do it by requesting manual rescan of the SCSI host.
> "echo - - - > /sys/class/scsi_host/hostX/scan".
>
> --
> tejun
>


-- 
"I have never let my schooling interfere with my education."
  - Samuel Langhorne Clemens
