From: Tejun Heo <tj@kernel.org>
Subject: Re: understanding the cause of ATA failures
Date: Thu, 25 Mar 2010 09:52:32 +0900
Message-ID: <4BAAB3D0.90704@kernel.org>
References: <4BA2A02F.7040200@gmail.com> <4BA2A27E.9040704@buttersideup.com> <4BA2A590.4030505@gmail.com> <4BA2AA34.70105@hardwarefreak.com> <4BA2B15E.6000301@gmail.com> <4BA2B9BE.5030607@hardwarefreak.com> <4BA2F19D.1090501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46666 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220Ab0CYHOL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 03:14:11 -0400
In-Reply-To: <4BA2F19D.1090501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Cc: Stan Hoeppner <stan@hardwarefreak.com>, linux-ide@vger.kernel.org

Hello,

On 03/19/2010 12:38 PM, Ludovico Cavedon wrote:
> Uhm, yes, you are right, it has a backplane with SES-2 over I2C support.
> At first I though that backplanes were used only on external enclosures.

If you have the machine locally, one thing you can try is to pull out
all the drives and hook them up directly to the motherboard bypassing
the backplane and see whether anything changes.

-- 
tejun
