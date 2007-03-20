From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 10:18:51 -0400
Message-ID: <41840b750703200718g49c3c1e3sd386f16e04d60b1f@mail.gmail.com>
References: <20070315110156.09e80b99.kristen.c.accardi@intel.com>
	 <20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	 <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2>
	 <20070319132243.GA2869@srcf.ucam.org>
	 <20070319134822.GA4885@homac2.suse.de>
	 <20070319140403.GA3697@srcf.ucam.org>
	 <20070319153659.GB15942@khazad-dum.debian.net>
	 <41840b750703190941p77fc4a64k49361b678dd6aa90@mail.gmail.com>
	 <20070319230420.GA5932@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:61116 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933455AbXCTOSw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 10:18:52 -0400
Received: by wr-out-0506.google.com with SMTP id 41so2039515wry
        for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 07:18:51 -0700 (PDT)
In-Reply-To: <20070319230420.GA5932@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On 3/19/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Mon, 19 Mar 2007, Shem Multinymous wrote:
> > Userspace wants to (non-force-)-unmount by itself after (1), so it can
> > stop  the eject process if the filesystems cannot be cleanly
> > unmounted. So the force-unmount at (3) ends up being a redundant
> > safety measure at best.
>
> More like it is a "make sure we can actually eject, as we have been told
> to".  We might return an error instead, but if we do, we need a way to
> force-eject (e.g. echo 2 >eject).

Which stage are you referring to?

Note that the only way to check if you can unmount is to actually do
so. Otherwise, you're very likely to run into race conditions with
someone accessing the filesystem between  the check and the actual
unmount.

  Shem
