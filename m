From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 12:12:54 -0300
Message-ID: <20070320151254.GA13042@khazad-dum.debian.net>
References: <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2> <20070319132243.GA2869@srcf.ucam.org> <20070319134822.GA4885@homac2.suse.de> <20070319140403.GA3697@srcf.ucam.org> <20070319153659.GB15942@khazad-dum.debian.net> <41840b750703190941p77fc4a64k49361b678dd6aa90@mail.gmail.com> <20070319230420.GA5932@khazad-dum.debian.net> <41840b750703200718g49c3c1e3sd386f16e04d60b1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59685 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933601AbXCTPM7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 11:12:59 -0400
Content-Disposition: inline
In-Reply-To: <41840b750703200718g49c3c1e3sd386f16e04d60b1f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Tue, 20 Mar 2007, Shem Multinymous wrote:
> >More like it is a "make sure we can actually eject, as we have been told
> >to".  We might return an error instead, but if we do, we need a way to
> >force-eject (e.g. echo 2 >eject).
> 
> Which stage are you referring to?

Stage 2, of course.  It is useful to have a force_eject functionality that
**will** eject and not error out because of anything other than the eject
command itself failing.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
