From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: v3.6 and up can't find HDD
Date: Fri, 14 Dec 2012 14:52:02 -0500
Message-ID: <50CB8362.1090601@pobox.com>
References: <CAOQxz3zHBtO=d1agOZQwfM4uVu7ysgAiNyoiziN6KUdu25=cQQ@mail.gmail.com> <50CB3CC1.6000300@intel.com> <CAOQxz3wTqGppkuN3EKcw94Vd2Yi1mNc_1DPJmwZcy7-xEWD9Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62391 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab2LNTwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2012 14:52:06 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so4590886vcd.19
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2012 11:52:06 -0800 (PST)
In-Reply-To: <CAOQxz3wTqGppkuN3EKcw94Vd2Yi1mNc_1DPJmwZcy7-xEWD9Uw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Labriola <michael.d.labriola@gmail.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Matthew Garrett <mjg@redhat.com>, linux-ide@vger.kernel.org, "Labriola, Michael" <mlabriol@gdeb.com>, jbolano@gdeb.com, "Dyke, Jayson" <jdyke@gdeb.com>, "Wehrly, Stuart" <swehrly@gdeb.com>

On 12/14/2012 02:41 PM, Michael Labriola wrote:
> Should udev even be loading pata_acpi on a recent system w/ only SATA devices?

Probably not, IMO.

	Jeff


