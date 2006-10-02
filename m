From: Tejun Heo <htejun@gmail.com>
Subject: Re: smartctl causing HSM violation on sata_nv, 2.6.18
Date: Tue, 03 Oct 2006 03:33:42 +0900
Message-ID: <45215B86.3020106@gmail.com>
References: <20060927183339.GA28174@jim.sh> <20060928065409.GI25800@htj.dyndns.org> <20060928080945.GA17964@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:9589 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965282AbWJBSdg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Oct 2006 14:33:36 -0400
Received: by nz-out-0102.google.com with SMTP id n1so547441nzf
        for <linux-ide@vger.kernel.org>; Mon, 02 Oct 2006 11:33:35 -0700 (PDT)
In-Reply-To: <20060928080945.GA17964@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: linux-ide@vger.kernel.org, smartmontools-support@lists.sourceforge.net

Jim Paris wrote:
> Hi Tejun,
> 
> Tejun Heo wrote:
>> The following patch against smartmontools-5.36 converts it to use
>> HDIO_DRIVE_TASK ioctl for AUTOSAVE and AUTO_OFFLINE which don't have
>> the above issue.
> 
> This patch works like a charm.  Now "smartctl -S on" and "smartctl -o on"
> works as expected on all of my SATA and IDE controllers.  Thank you!

I've got delivery failure notice for smartmontools-support mail address. 
  Does anyone know how to contact smartmontools author?

Thanks.

-- 
tejun
