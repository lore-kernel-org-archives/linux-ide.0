From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 9/9] add hotplug support
Date: Wed, 12 Apr 2006 10:49:01 +0900
Message-ID: <443C5C8D.1060108@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.203]:34451 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbWDLBtP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 21:49:15 -0400
Received: by xproxy.gmail.com with SMTP id t10so915966wxc
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 18:49:14 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hellooooo, all.
> 
> Finally, the last one.  This is the first take of add-hotplug-support
> patchset.  This patchset includes 13 patches.

And, of course, 15 patches.

> #01-04	implement hotplug framework
> #05-07	implement warm plug (SCSI scan/delete callbacks)
> #08-10	hook and activate hotplug
#11-12		prep sata_sil for hotplug support
#13-15		add LLDD hotplug supports (PHY status change notifications)

-- 
tejun
