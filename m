From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: Sil 3124 Pci Express?
Date: Mon, 30 Oct 2006 10:33:12 -0700
Message-ID: <311601c90610300933k4cd2bad8sb37f698adb01fdae@mail.gmail.com>
References: <f4527be0610281237x33c05f75j82879ba1c90b9e4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:31471 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030559AbWJ3RdP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 12:33:15 -0500
Received: by wr-out-0506.google.com with SMTP id i7so286441wra
        for <linux-ide@vger.kernel.org>; Mon, 30 Oct 2006 09:33:14 -0800 (PST)
In-Reply-To: <f4527be0610281237x33c05f75j82879ba1c90b9e4a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10/28/06, Andrew Lyon <andrew.lyon@gmail.com> wrote:
> Hi,
>
> Can anybody recommend a Pci Express Sil 3124 card?
> http://linux-ata.org/driver-status.html#sii3124 shows that this is the
> best supported chip, I am looking for a card with 4 or more ports, any
> suggestions?

3124, as was said above, is a PCI-X/PCI chipset.  Most of the
implementations using this chip will work in both normal PCI and PCI-X
slots.

They have a 3132 which is their PCI-e (x1) chipset, but I don't think
they ever made a 4-port version, just the 2-port version.
