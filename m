From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Tue, 26 Jan 2016 10:56:20 -0600
Message-ID: <56A7A534.6040208@amd.com>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <20160125204300.GM3628@mtj.duckdns.org> <5730117.gx9ezcyLp7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2on0079.outbound.protection.outlook.com ([65.55.169.79]:36944
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933988AbcAZQ6t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jan 2016 11:58:49 -0500
In-Reply-To: <5730117.gx9ezcyLp7@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>
Cc: brijesh.singh@amd.com, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org

Hi Arnd,

On 01/26/2016 06:17 AM, Arnd Bergmann wrote:
> 
> I think it needs more work: The changelog describes it as a normal
> driver, but based on the previous discussion, this is just a hack
> to work around broken BIOS versions that can no longer be fixed in
> the field, and there has not been a decision what the proper
> representation should be in ACPI.
> 
I am not sure if we should label this driver as a hack to workaround the
broken BIOS. Unfortunately SoC did not implemented the enclosure management
per spec. Its not BIOS issue.

> The patch also fails to address the devicetree based case, even though
> we did come to a conclusion that the current behavior is a regression
> (compared to what we had in drivers/ide/) and that there is a relatively
> simple fix to do it right.
> 
I did looked at your recommendation for extending libahci to use ledtrig_ide_activity()
but as I pointed out in previous discussion this function is missing several key features
from EM (enclosure management) pov. e.g missing the slot number, missing the locate and fault led.
In case of EM, each port will have at least three leds (activity, locate and fault). 
Since these LED's are part of EM hence we need to ensure that tools like ledmon and ledctl (which uses libahci sysfs) works well.

The main question is, what is recommended approach to override libachi enclosure managements
transfer led messages function? A platform driver or something else.

Tejun and/or Hans do you have any recommendation ?


- Brijesh
