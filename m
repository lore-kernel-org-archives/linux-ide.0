From: Tejun Heo <htejun@gmail.com>
Subject: Re: question on hotplug on ICH8M
Date: Wed, 30 Aug 2006 12:19:02 +0900
Message-ID: <44F503A6.5030208@gmail.com>
References: <20060829101039.8a1ec81e.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:4297 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751067AbWH3DT6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 23:19:58 -0400
Received: by py-out-1112.google.com with SMTP id n25so70231pyg
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2006 20:19:58 -0700 (PDT)
In-Reply-To: <20060829101039.8a1ec81e.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org

Kristen Carlson Accardi wrote:
> hi,
> I have a CD/DVD rom device on an ICH8M that and the ahci driver that
> I am trying to hot remove with kernel 2.6.18-rc4-git.  It seems that
> hotplug for this device should be supported.  Do I need to do anything
> special to hot remove this device (such as write to some sysfs file),
> or can I just "pull the plug" so to speak?

Just pulling the plug should work.

-- 
tejun
