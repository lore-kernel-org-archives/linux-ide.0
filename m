From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Fri, 18 Mar 2016 16:19:37 -0400
Message-ID: <20160318201937.GG20028@mtj.duckdns.org>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <5709817.yQT8N3CaLj@wuerfel>
 <20160316210713.GI21104@mtj.duckdns.org>
 <31951835.kMFH9CgruZ@wuerfel>
 <56EC4AB8.7040901@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f65.google.com ([209.85.192.65]:34308 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbcCRUTk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2016 16:19:40 -0400
Content-Disposition: inline
In-Reply-To: <56EC4AB8.7040901@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org, Graeme Gregory <graeme@xora.org.uk>

Hello,

On Fri, Mar 18, 2016 at 01:36:40PM -0500, Brijesh Singh wrote:
> > It's your call in the end. My main objection is to the fact that
> > I have suggested a clean implementation for the normal DT based
> > path that also fixes existing platforms that used to work in the
> > past and were broken by the (long-ago) move from drivers/ide to
> > drivers/ata, Brijesh has not implemented that but has instead
> > continued pushing the hack for the ACPI mode that is still
> > experimental on ARM64.
> 
> I am helping a customer who want EM support in a distro (using ACPI
> mode). Since its difficult to update the bios hence can I request to
> pull this driver. The driver solves the ACPI usecases.
>
> As per DT is concerned, will look into driver/ide and led framework
> but since I am not very familiar with driver/ide and led framework
> hence it will take sometime to design and implement the DT cases.

Alright, will route it through for-4.6-fixes after the merge window
but please do look into the issue that Arnd raised.

Thanks.

-- 
tejun
