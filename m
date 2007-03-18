From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: CONFIG_IBM_BAY
Date: Sun, 18 Mar 2007 16:00:18 -0300
Message-ID: <20070318190018.GC29422@khazad-dum.debian.net>
References: <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2> <20070318183652.GB29422@khazad-dum.debian.net> <20070318185529.GA14885@homac2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070318185529.GA14885@homac2>
Sender: linux-acpi-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, 18 Mar 2007, Holger Macht wrote:
> It doesn't work, I've already tried. The bay driver only emits an event if
> you really try to remove the bay, but not on docking/undocking.

Ah, now I understand what you mean.

Looks like we really need the dock driver to sort of like act as a bus.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
