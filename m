From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND 2/3] ahci: add AMD CZ SATA device ID
Date: Tue, 4 Jun 2013 15:39:47 -0600
Message-ID: <CAErSpo5omduEpNv-DC31FJYGM=R-QaNYDikcAKHNSHeTEf2YCA@mail.gmail.com>
References: <1370255050-2358-1-git-send-email-shane.huang@amd.com>
 <51AC6A14.2040908@cogentembedded.com> <CAErSpo5Jh_znOjr0CRBN=Kay+Y2ZJ2dDfVJdVW7MW9TjFzB6Yg@mail.gmail.com>
 <43EB3AB3EEFE8D43B525F4D2EAF507E1085B9F73@SCYBEXDAG04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1085B9F73@SCYBEXDAG04.amd.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tejun Heo <tj@kernel.org>, Jean Delvare <khali@linux-fr.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jun 3, 2013 at 8:09 PM, Huang, Shane <Shane.Huang@amd.com> wrote:
> Bjorn,
>
>> Let me know if anybody objects.  Otherwise, I'll merge it into my
>> -next branch tomorrow.
>
> The change is fine with me, thanks to you and Sergei.

OK, all three are now in the PCI -next branch, headed for v3.11.

After removing the dependences on pci_ids.h, they could have gone
individually via i2c and ahci trees, but in the interest of getting on
with it, I just put them in.

Bjorn
