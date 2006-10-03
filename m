From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: SATA status reports update
Date: Tue, 3 Oct 2006 05:02:25 +0200
Message-ID: <41840b750610022002j4d73ab23l83a88ec757925b08@mail.gmail.com>
References: <451CE8EC.1020203@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:23193 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWJCDC2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Oct 2006 23:02:28 -0400
Received: by ug-out-1314.google.com with SMTP id o38so580918ugd
        for <linux-ide@vger.kernel.org>; Mon, 02 Oct 2006 20:02:27 -0700 (PDT)
In-Reply-To: <451CE8EC.1020203@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Tejun Heo <htejun@gmail.com>

Hi Jeff,

On 9/29/06, Jeff Garzik <jeff@garzik.org> wrote:
> Software status:
>         http://linux-ata.org/software-status.html

It says:
"Over and above the power management specified in the ATA/ATAPI
specification, one can aggressively control the power consumption of
SATA hosts, the SATA bus, and the SATA device. [...]
There is little demand at the present time for aggressive, automatic
power management under Linux."


What about laptops on batteries? Pavel reports a 1W power draw by his
ThinkPad's ICH7M SATA controller [1]. It would be neat to eliminate
this when the disk is not in use (and powering up the silicon can't
take much longer than spinning up a chunk glass to 7200RPM).

  Shem

[1] http://atrey.karlin.mff.cuni.cz/~pavel/swsusp/8hours.pdf
    slide 11
