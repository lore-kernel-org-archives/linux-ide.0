From: Richard Zhu <richard.zhu@linaro.org>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
	different features
Date: Tue, 30 Aug 2011 15:07:20 +0800
Message-ID: <CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
	<20110829121214.GA15484@oksana.dev.rtsoft.ru>
	<CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
	<CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Miao <eric.miao@linaro.org>
Cc: eric@eukrea.com, linux-ide@vger.kernel.org, kernel@pengutronix.de, Anton Vorontsov <cbouatmailru@gmail.com>, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi:
One more concern, the .../drivers/ata/ahci.h file should be moved to
.../include/linux/ folder.
Because that the kinds of macros used in the ata_port_info and the
ahci_pmp_retry_srst_ops are
all defined in the .../drivers/ata/ahci.h file.
Otherwise, the ata_port_info can't be defined in the board related
platform data.

How we can handle this case?

Best Regard
Richard Zhu

On 30 August 2011 14:21, Richard Zhu <richard.zhu@linaro.org> wrote:
> Hi:
> Pass port info from the platform data is a good idea.
> About the codes duplication in the board level, I think that we can
> re-use the default =A0port info on most boards, when the ata_port_info
> is null in the platform data struct.
> We can leave the ahci_platform.c without any modifications in this way.
>
> How do you guys think about?
>
> Best Regard
> Richard Zhu
>
>
> On 29 August 2011 20:25, Eric Miao <eric.miao@linaro.org> wrote:
>> On Mon, Aug 29, 2011 at 8:12 PM, Anton Vorontsov <cbouatmailru@gmail.com=
> wrote:
>>> Hello,
>>>
>>> On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
>>>> On imx53 AHCI, soft reset fails with IPMS set when PMP
>>>> is enabled but SATA HDD/ODD is connected to SATA port,
>>>> do soft reset again to port 0.
>>>> So the 'ahci_pmp_retry_srst_ops' is required when imx53
>>>> ahci is present.
>>>>
>>>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>>>> ---
>>> [...]
>>>> =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
>>>> =A0 =A0 =A0 struct ahci_platform_data *pdata =3D dev->platform_data;
>>>> - =A0 =A0 struct ata_port_info pi =3D {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D AHCI_FLAG_COMM=
ON,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 .pio_mask =A0 =A0 =A0 =3D ATA_PIO4,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 .udma_mask =A0 =A0 =A0=3D ATA_UDMA6,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 .port_ops =A0 =A0 =A0 =3D &ahci_ops,
>>>> - =A0 =A0 };
>>>> + =A0 =A0 struct platform_device_id *id_entry =3D platform_get_device_=
id(pdev);
>>>> + =A0 =A0 struct ata_port_info pi =3D ahci_port_info[id_entry->driver_=
data];
>>>
>>> Why not pass port info via platform_data? It seems to be platform
>>> specific nowadays, so leave the default as is, but let the platforms
>>> pass their own port info through platform_data.
>>
>> That's also a very clean way. However I have the concern that it might
>> end up with many duplicate entries.
>>
>>>
>>> Thanks,
>>>
>>> --
>>> Anton Vorontsov
>>> Email: cbouatmailru@gmail.com
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>
